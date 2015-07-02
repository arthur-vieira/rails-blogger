class CommentsController < ApplicationController
	before_filter :require_login, except: [:create] # haven't implemented index and destroy yet, but just in case...

	include CommentsHelper
	def create
		@comment = Comment.new(comment_params)
		@comment.article_id = params[:article_id]
		@comment.save
		redirect_to article_path(@comment.article)
	end
end
