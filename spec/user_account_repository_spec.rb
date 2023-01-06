require_relative '../lib/user_repo'

RSpec.describe UserAccountRepository do 

    def reset_users_table
        seed_sql = File.read('spec/user_account_seeds.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
        connection.exec(seed_sql)
    end

    before(:each) do 
        reset_users_table
    end

    it ' gets all users ' do 
        repo = UserAccountRepository.new

        users = repo.all

        expect(users.length).to eq(2)

        expect(users[0].id).to eq('1')
        expect(users[0].email).to eq('example@example.com')
        expect(users[0].user_name).to eq('unicorn')

        expect(users[1].id).to eq('2')
        expect(users[1].email).to eq('lalala@blablabla.com')
        expect(users[1].user_name).to eq('butterfly')
    end 

    it ' finds the user by id' do 
        repo = UserAccountRepository.new

        user = repo.find(1)

        expect(user.id).to eq('1')
        expect(user.email).to eq('example@example.com')
        expect(user.user_name).to eq('unicorn')

    end 

    it 'creates new user' do 
        repo = UserAccountRepository.new

        user = User.new

        user.email = 'example11@example.com'
        user.user_name  = 'unicorn11'

        repo.create(user)
        user = repo.all
        last_user = user.last
        expect(last_user.email).to eq('example11@example.com')
        expect(last_user.user_name).to eq('unicorn11')
    end

    it ' deletes user with given id ' do 
        repo = UserAccountRepository.new

        id_to_delete = 1
        repo.delete(id_to_delete)

        all_users = repo.all
        expect(all_users.length).to eq 1
        expect(all_users.first.id).to eq('2')

    end 

    it 'updates the user' do 
        repo = UserAccountRepository.new

        user = repo.find(1)

        user.email = 'another@email.com'
        user.user_name = 'just_horse'

        repo.update(user)

        updated_user = repo.find(1)

        expect(updated_user.email).to eq('another@email.com')
        expect(updated_user.user_name).to eq('just_horse')
    end
end