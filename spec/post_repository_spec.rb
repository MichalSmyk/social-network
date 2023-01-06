require_relative '../lib/post_repo'

RSpec.describe PostRepository do 

    def reset_posts_table
        seed_sql = File.read('spec/user_account_seeds.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
        connection.exec(seed_sql)
    end
      
     
    before(:each) do 
        reset_posts_table
    end

    it 'gets all posts ' do 
        repo = PostRepository.new

        posts = repo.all
        
        expect(posts.length).to eq(2)
        
        expect(posts[0].id).to eq('1')
        expect(posts[0].content).to eq('first content')
        expect(posts[0].title).to eq('first title')
        expect(posts[0].view).to eq('25')
        expect(posts[0].user_id).to eq('1')
        
        expect(posts[1].id).to eq('2')
        expect(posts[1].content).to eq('second content')
        expect(posts[1].title).to eq('second title')
        expect(posts[1].view).to eq('15')
        expect(posts[1].user_id).to eq('2')
    end 
    it 'finds one post ' do 
        repo = PostRepository.new

        post = repo.find(1)
        expect(post.id).to eq('1')
        expect(post.content).to eq('first content')
        expect(post.title).to eq('first title')
        expect(post.view).to eq('25')
        expect(post.user_id).to eq('1')
    end 
    it 'creates new post ' do 
        repo = PostRepository.new

        post = Post.new

        post.content = 'third content'
        post.title = 'third title'
        post.view  = '255'
        post.user_id = '2'

        repo.create(post)
        post = repo.all
        last_post = post.last
        expect(last_post.content).to eq('third content')
        expect(last_post.title).to eq('third title')
        expect(last_post.view).to eq('255')
        expect(last_post.user_id).to eq('2')
    end 
    it 'deletes post with given id ' do 
        repo = PostRepository.new

        id_to_delete = 1
        repo.delete(id_to_delete)

        all_posts = repo.all
        expect(all_posts.length).to eq(1)
        expect(all_posts.first.id).to eq('2')
    end 
    it 'updates the post ' do 
        repo = PostRepository.new

        post = repo.find(1)

        post.content = 'forth content'
        post.title =  'forth title'
        post.view =  '100'
        post.user_id  =  '2'

        repo.update(post)

        updated_posts = repo.find(1)

        expect(updated_posts.content).to eq('forth content')
        expect(updated_posts.title).to eq('forth title')
        expect(updated_posts.view).to eq('100')
        expect(updated_posts.user_id).to eq('2')
    end 
end 