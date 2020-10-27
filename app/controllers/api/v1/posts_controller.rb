module Api
    module V1
        class PostsController < ApplicationController
            include ActionController::HttpAuthentication::Basic::ControllerMethods

            http_basic_authenticate_with name: ENV["BLOG_USERNAME"],password: ENV["BLOG_PASSWORD"]

            def index
                posts = Post.order('created_at DESC');
                render json: {status: 'SUCCESS', message: 'Loaded Posts', data:posts},status: :ok
            end

            def show
                post = Post.find(params[:id])
                render json: {status: 'SUCCESS', message:'Loaded post', data:post},status: :ok
            end 

            def create
                post = Post.new(post_params)

                if post.save
                    render json: {status: 'SUCCESS', message:'saved post', data:post},status: :ok
                else
                    render json: {status: 'ERROR', message:'post not saved', data:post.errors},status: :unprocessable_entry

                end

            end

            def destroy
                post = Post.find(params[:id])
                post.destroy
                render json: {status: 'SUCCESS', message:'deleted post', data:post},status: :ok

            end

            def update
                post = Post.find(params[:id])
                if post.update_attributes(post_params)
                    render json: {status: 'SUCCESS', message:'updated post', data:post},status: :ok
                else
                    render json: {status: 'ERROR', message:'post not saved', data:post.errors},status: :unprocessable_entry
                end
            end

            private
            def post_params
                params.permit(:title, :body)
            end
        end
    end
end