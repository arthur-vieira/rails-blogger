class ArticlesController < ApplicationController
	include ArticlesHelper
	def index
		@articles = Article.all
	end
	def show
		@article = Article.find(params[:id])
	end
	def new
		@article = Article.new
	end
	def create
			#fail # The fail method will halt the request allowing you to examine the request parameters.
		@article = Article.new(article_params) # Instead of the line below, create and use module ArticlesHelper
			#@article = Article.new(params.require(:article).permit(:title, :body)) # require/permit help you declare which attributes you’d like to accept.
			#@article = Article.new(params[:article]) # For security reasons, it’s not a good idea to blindly save parameters sent into us via the params hash.
			# cleaning these commented lines up in just one single line (the line above)
			#@article.title = params[:article][:title]
			#@article.body = params[:article][:body]
		@article.save
		flash.notice = "Article '#{@article.title}' Created!"
		redirect_to article_path(@article)
	end
	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		flash.notice = "Article '#{@article.title}' Deleted!"
		redirect_to articles_path
	end
	def edit
		@article = Article.find(params[:id])
	end
	def update
		@article = Article.find(params[:id])
		@article.update(article_params)
		flash.notice = "Article '#{@article.title}' Updated!"
		redirect_to article_path(@article)
	end
end
