require 'net/http'
require 'json'

unless Rails.env.production?
    def fetch_api_data(url)
        uri = URI(url)
        response = Net::HTTP.get(uri)
        JSON.parse(response)
    rescue StandardError => e
        puts "❌ #{e.message}"
        exit
    end

    # categories
    categories = fetch_api_data('https://fakestoreapi.com/products/categories')

    if categories.nil?
        puts I18n.t("db_seed.errors.warning_categories")
        exit
    end

    categories.each do |c|
        Category.find_or_create_by(description: c) do |category|
            category.active = true
        end
    end

    if Category.all.size == 0
        puts I18n.t("db_seed.errors.size_category")
        exit
    end

    puts I18n.t("db_seed.category.save_success")

    # products

    products = fetch_api_data('https://fakestoreapi.com/products')

    if products.nil?
        puts I18n.t("db_seed.errors.warning_products")
        exit
    end

    products.each do |p|
        Product.find_or_create_by(title: p["title"]) do |product|
            product.description = p["description"]
            product.price = p["price"]
            product.category = Category.find_by(description: p["category"])
            product.url_image = p["image"]
        end
    end

    if Product.all.size == 0
        puts I18n.t("db_seed.errors.warning_products")
        exit
    end

    puts I18n.t("db_seed.product.save_success")

    # Product.find_or_create_by(title: product["title"]) do |p|
    #     p.price = product["price"]
    #     p.description = product["description"]
    #   end
    #users = fetch_api_data('https://fakestoreapi.com/users')
    puts I18n.t("db_seed.end")
else
    puts I18n.t("db_seed.errors.warning_production")
end