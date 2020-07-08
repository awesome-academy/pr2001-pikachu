# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_200_624_101_608) do
  create_table 'booking_tours', force: :cascade do |t|
    t.integer 'tour_detail_id', null: false
    t.integer 'user_id', null: false
    t.integer 'quantity'
    t.float 'price_total'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['tour_detail_id'], name: 'index_booking_tours_on_tour_detail_id'
    t.index ['user_id'], name: 'index_booking_tours_on_user_id'
  end

  create_table 'categories', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'comments', force: :cascade do |t|
    t.integer 'review_id', null: false
    t.integer 'user_id', null: false
    t.text 'content'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['review_id'], name: 'index_comments_on_review_id'
    t.index ['user_id'], name: 'index_comments_on_user_id'
  end

  create_table 'images', force: :cascade do |t|
    t.integer 'tour_id', null: false
    t.string 'link'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['tour_id'], name: 'index_images_on_tour_id'
  end

  create_table 'likes', force: :cascade do |t|
    t.integer 'review_id', null: false
    t.integer 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['review_id'], name: 'index_likes_on_review_id'
    t.index ['user_id'], name: 'index_likes_on_user_id'
  end

  create_table 'ratings', force: :cascade do |t|
    t.integer 'tour_id', null: false
    t.integer 'user_id', null: false
    t.integer 'rate'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['tour_id'], name: 'index_ratings_on_tour_id'
    t.index ['user_id'], name: 'index_ratings_on_user_id'
  end

  create_table 'reviews', force: :cascade do |t|
    t.integer 'tour_id', null: false
    t.integer 'user_id', null: false
    t.text 'content'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['tour_id'], name: 'index_reviews_on_tour_id'
    t.index ['user_id'], name: 'index_reviews_on_user_id'
  end

  create_table 'tour_details', force: :cascade do |t|
    t.integer 'tour_id', null: false
    t.date 'departure_time'
    t.date 'return_time'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['tour_id'], name: 'index_tour_details_on_tour_id'
  end

  create_table 'tours', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.integer 'price'
    t.integer 'category_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'coupon'
    t.integer 'seats'
    t.index ['category_id'], name: 'index_tours_on_category_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.string 'password_digest'
    t.string 'remember_digest'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.boolean 'admin', default: false
    t.index ['email'], name: 'index_users_on_email', unique: true
  end

  add_foreign_key 'booking_tours', 'tour_details'
  add_foreign_key 'booking_tours', 'users'
  add_foreign_key 'comments', 'reviews'
  add_foreign_key 'comments', 'users'
  add_foreign_key 'images', 'tours'
  add_foreign_key 'likes', 'reviews'
  add_foreign_key 'likes', 'users'
  add_foreign_key 'ratings', 'tours'
  add_foreign_key 'ratings', 'users'
  add_foreign_key 'reviews', 'tours'
  add_foreign_key 'reviews', 'users'
  add_foreign_key 'tour_details', 'tours'
  add_foreign_key 'tours', 'categories'
end
