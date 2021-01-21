# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_reading  | string | null: false |
| first_name_reading | string | null: false |
| email              | string | null: false |
| password           | string | null: false |

### Association

- has_many :items
- has_many :comments
- has_one  :address 
- has_one  :order

## items テーブル

| Column | Type       | Options     |
| ------ | ---------- | ----------- |
| title  | string     | null: false |
| text   | text       | null: false |
| price  | integer    | null: false |
| user   | references | null: false |

### Association

- belongs_to :user
- has_many   :comments
- has_one    :order

## comments テーブル

| Column | Type       | Options     |
| ------ | ---------- | ----------- |
| text   | text       | null: false |
| user   | references |             |
| item   | references |             |

### Association

- belongs_to :user
- belongs_to :item

## addresses テーブル

| Column        | Type       | Options     |
| ------------- | ---------- | ----------- |
| post_number   | string     | null: false |
| prefecture    | integer    | null: false |
| city          | string     | null: false |
| house_number  | string     | null: false |
| building_name | string     | null: false |
| phone_number  | string     | null: false |
| user          | references |             |

### Association

- belongs_to :user
- has_one    :order

## orders テーブル

| Column    | Type       | Options |
| --------- | ---------- | ------- |
| user      | references |         |
| item      | references |         |
| addresses | references |         |

### Association

- belongs_to :user
- belongs_to :item
- belongs_to :address
