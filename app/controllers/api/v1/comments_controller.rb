module Api
    module V1
        class CommentsController < ApplicationController
            include ActionController::HttpAuthentication::Basic::ControllerMethods
            http_basic_authenticate_with name: "dt", password:"qwe", only: [:destroy]

            def create
                post = Post.find(params[:post_id])
                comment = post.comments.create(comment_params)

                if comment.save
                    render json: {status: 'SUCCESS', message:'saved comment', data:comment},status: :ok
                else
                    render json: {status: 'ERROR', message:'comment not saved', data:comment.errors},status: :unprocessable_entry

                end
            end

            def destroy
                post = Post.find(params[:post_id])
                comment = post.comments.find(params[:id])
                comment.destroy

                render json: {status: 'SUCCESS', message:'deleted comment', data:comment},status: :ok
                
            end


            private
             def comment_params
                params.require(:comment).permit(:username, :body)
             end

        end
    end
end