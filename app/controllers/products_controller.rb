class ProductsController < RankingController
  before_action :authenticate_user!, only: :search

  def index
    # productsテーブルから最新順に作品を２０件取得する
    @products = Product.order('id asc').limit(20)
  end

  def show
    # productsテーブルから該当するidの作品情報を取得し@productの変数へ代入する処理を書いて下さい
    @product = Product.find(params[:id])
  end

  # SQLインジェクションリスクあり
  # def search
  #   @products = Product.find_by_sql("select * from products where title like '%#{params[:keyword]}%' LIMIT 20")
  # end

  # SQLインジェクション対策済み
  def search
    keyword = "%#{params[:keyword]}%"
    @products = Product.find_by_sql(["select * from products where title like ? LIMIT 20", keyword])
  end

  # def search
  #   # 検索フォームのキーワードをあいまい検索して、productsテーブルから20件の作品情報を取得する
  #   @products = Product.where('title LIKE(?)', "%#{params[:keyword]}%").limit(20)
  #   respond_to do |format|
  #     format.html
  #     format.json
  #   end
  # end
end
