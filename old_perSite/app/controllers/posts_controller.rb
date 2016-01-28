class PostsController < ApplicationController

	def index
		@posts = Post.all
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@post.author = current_user
		if @post.save
			redirect_to post_path(@post)
		else
			render "new"
		end
	end

	def show
		@post = Post.includes(:author).find_by_id(params[:id])
	end

	def edit
		@post = Post.find_by_id(params[:id])
		redirect_to post_path(@post) unless current_user && current_user.owns?(@post)
	end

	def update
		@post = current_user.posts.find_by_id(params[:id]) if current_user
		if @post && @post.save
			redirect_to post_path(@post)
		else
			@error_object = @post
			render "edit"
		end
		
	end

	def destroy
		post = current_user.posts.find_by_id(params[:id])
		post.destroy if post
		redirect_to posts_path
	end

	private
	def post_params
		params.require(:post).permit(:title, :body)
	end

end
