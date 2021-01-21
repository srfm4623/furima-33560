# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_reading  | string | null: false |
| first_name_reading | string | null: false |
| nickname           | string | null: false |
| date               | date   | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |

### Association

- has_many :items
- has_many :comments
- has_many :orders

## items テーブル

| Column           | Type       | Options           |
| ---------------- | ---------- | ----------------- |
| title            | string     | null: false       |
| text             | text       | null: false       |
| category_id      | integer    | null: false       |
| condition_id     | integer    | null: false       |
| shipping_cost_id | integer    | null: false       |
| prefecture_id    | integer    | null: false       |
| arrival_date_id  | integer    | null: false       |
| price            | integer    | null: false       |
| user             | references | foreign_key: true |

### Association

- belongs_to :user
- has_many   :comments
- has_one    :order

## comments テーブル

| Column | Type       | Options           |
| ------ | ---------- | ----------------- |
| text   | text       | null: false       |
| user   | references | foreign_key: true |
| item   | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## addresses テーブル

| Column        | Type       | Options           |
| ------------- | ---------- | ----------------- |
| post_number   | string     | null: false       |
| prefecture_id | integer    | null: false       |
| city          | string     | null: false       |
| house_number  | string     | null: false       |
| building_name | string     |                   |
| phone_number  | string     | null: false       |
| order         | references | foreign_key: true |

### Association

- belongs_to :order

## orders テーブル

| Column  | Type       | Options           |
| ------- | ---------- | ----------------- |
| user_id | references | foreign_key: true |
| item_id | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one    :address
