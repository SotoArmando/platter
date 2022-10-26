var jsonfile = {
  "actitivities": {
    "Fields": {
      "keys": [
        'CheftId',
        'CalendarString',
        'created_at',
        'updated_at',
        'create_table "actitivities_recipes"'
      ]
    }
  },
  "actitivities_recipes": {
    "Fields": {
      "keys": [
        'actitivitie_id',
        'recipe_id',
        'index_actitivities_recipes_on_actitivitie_id',
        'index_actitivities_recipes_on_recipe_id',
        'create_table "appusers"'
      ]
    }
  },
  "appusers": {
    "Fields": {
      "keys": [
        'Password',
        'created_at',
        'updated_at',
        'create_table "appusers_identities"'
      ]
    }
  },
  "appusers_identities": {
    "Fields": {
      "keys": [
        'appuser_id',
        'identity_id',
        'index_appusers_identities_on_appuser_id',
        'index_appusers_identities_on_identity_id',
        'create_table "assistants"'
      ]
    }
  },
  "assistants": { "Fields": { "keys": ['created_at', 'updated_at', 'create_table "calendars"'] } },
  "calendars": {
    "Fields": {
      "keys": [
        'CalendarString',
        'CheftId',
        'created_at',
        'updated_at',
        'create_table "calendars_recipes"'
      ]
    }
  },
  "calendars_recipes": {
    "Fields": {
      "keys": [
        'calendar_id',
        'recipe_id',
        'index_calendars_recipes_on_calendar_id',
        'index_calendars_recipes_on_recipe_id',
        'create_table "chefts"'
      ]
    }
  },
  "chefts": {
    "Fields": {
      "keys": [
        'title',
        'created_at',
        'updated_at',
        'create_table "components"'
      ]
    }
  },
  "components": {
    "Fields": {
      "keys": [
        'Description',
        'created_at',
        'updated_at',
        'create_table "components_foodreferences"'
      ]
    }
  },
  "components_foodreferences": {
    "Fields": {
      "keys": [
        'component_id',
        'foodreference_id',
        'index_components_foodreferences_on_component_id',
        'index_components_foodreferences_on_foodreference_id',
        'create_table "components_measurereferences"'
      ]
    }
  },
  "components_measurereferences": {
    "Fields": {
      "keys": [
        'component_id',
        'measurereference_id',
        'index_components_measurereferences_on_component_id',
        'index_components_measurereferences_on_measurereference_id',
        'create_table "components_recipes"'
      ]
    }
  },
  "components_recipes": {
    "Fields": {
      "keys": [
        'recipe_id',
        'component_id',
        'index_components_recipes_on_component_id',
        'index_components_recipes_on_recipe_id',
        'create_table "components_stocks"'
      ]
    }
  },
  "components_stocks": {
    "Fields": {
      "keys": [
        'component_id',
        'stock_id',
        'index_components_stocks_on_component_id',
        'index_components_stocks_on_stock_id',
        'create_table "conditions"'
      ]
    }
  },
  "conditions": {
    "Fields": {
      "keys": [
        'Applications',
        'Name',
        'CheftId',
        'created_at',
        'updated_at',
        'create_table "contents"'
      ]
    }
  },
  "contents": {
    "Fields": {
      "keys": [
        'BodySettingString',
        'PictureSettingsString',
        'DocumentIndexSettingsString',
        'created_at',
        'updated_at',
        'create_table "contents_recipes"'
      ]
    }
  },
  "contents_recipes": {
    "Fields": {
      "keys": [
        'recipe_id',
        'content_id',
        'index_contents_recipes_on_content_id',
        'index_contents_recipes_on_recipe_id',
        'create_table "family_menus"'
      ]
    }
  },
  "family_menus": {
    "Fields": {
      "keys": [
        'MenuSettingString',
        'CheftId',
        'created_at',
        'updated_at',
        'create_table "family_menus_recipes"'
      ]
    }
  },
  "family_menus_recipes": {
    "Fields": {
      "keys": [
        'family_menu_id',
        'recipe_id',
        'index_family_menus_recipes_on_family_menu_id',
        'index_family_menus_recipes_on_recipe_id',
        'create_table "foodreferences"'
      ]
    }
  },
  "foodreferences": {
    "Fields": {
      "keys": [
        'Name',
        'Data',
        'created_at',
        'updated_at',
        'create_table "identities"'
      ]
    }
  },
  "identities": {
    "Fields": {
      "keys": [
        'Name',
        'Avatar',
        'Mail',
        'Creation_Date',
        'Valid_Since',
        'Expires',
        'created_at',
        'updated_at',
        'create_table "measurereferences"'
      ]
    }
  },
  "measurereferences": {
    "Fields": {
      "keys": [
        'Name',
        'Amount',
        'created_at',
        'updated_at',
        'create_table "menus"'
      ]
    }
  },
  "menus": {
    "Fields": {
      "keys": [
        'MenuSettingString',
        'CheftId',
        'created_at',
        'updated_at',
        'create_table "menus_recipes"'
      ]
    }
  },
  "menus_recipes": {
    "Fields": {
      "keys": [
        'menu_id',
        'recipe_id',
        'index_menus_recipes_on_menu_id',
        'index_menus_recipes_on_recipe_id',
        'create_table "metafiles"'
      ]
    }
  },
  "metafiles": {
    "Fields": {
      "keys": [
        'url',
        'file',
        'created_at',
        'updated_at',
        'create_table "order_feedbacks"'
      ]
    }
  },
  "order_feedbacks": {
    "Fields": {
      "keys": ['OrderId', 'created_at', 'updated_at', 'create_table "orders"']
    }
  },
  "orders": {
    "Fields": {
      "keys": ['created_at', 'updated_at', 'create_table "orders_recipes"']
    }
  },
  "orders_recipes": {
    "Fields": {
      "keys": [
        'recipe_id',
        'order_id',
        'index_orders_recipes_on_order_id',
        'index_orders_recipes_on_recipe_id',
        'create_table "pictures"'
      ]
    }
  },
  "pictures": {
    "Fields": {
      "keys": [
        'metafile_id',
        'created_at',
        'updated_at',
        'index_pictures_on_metafile_id',
        'create_table "pictures_recipes"'
      ]
    }
  },
  "pictures_recipes": {
    "Fields": {
      "keys": [
        'recipe_id',
        'picture_id',
        'index_pictures_recipes_on_picture_id',
        'index_pictures_recipes_on_recipe_id',
        'create_table "recipes"'
      ]
    }
  },
  "recipes": {
    "Fields": {
      "keys": [
        'BodySettingsString',
        'PictureSettingsString',
        'DocumentIndexSettingsString',
        'created_at',
        'updated_at',
        'create_table "recipes_stocks"'
      ]
    },
    "Correlations": {
      "keys": ["stocks", "actitivities","components", "menus", "tags", "orders","pictures", "family_menus", "contents", "calendars"],
      "components": {
        "required": true,
      },
      "tags": {
        "required": true,
      },
      "contents": {
        "required": true,
      }
    }
  },
  "recipes_stocks": {
    "Fields": {
      "keys": [
        'recipe_id',
        'stock_id',
        'index_recipes_stocks_on_recipe_id',
        'index_recipes_stocks_on_stock_id',
        'create_table "settings"'
      ]
    }
  },
  "settings": {
    "Fields": {
      "keys": [
        'SettingsString',
        'created_at',
        'updated_at',
        'create_table "stocks"'
      ]
    }
  },
  "stocks": {
    "Fields": {
      "keys": [
        'PreserveDuraction',
        'CookDuration',
        'BodySettingsString',
        'created_at',
        'updated_at',
        'create_table "tags"'
      ]
    }
  },
  "tags": {
    "Fields": {
      "keys": [
        'name',
        'description',
        'discrete',
        'created_at',
        'updated_at',
        'create_table "tags_assistants"'
      ]
    }
  },
  "tags_assistants": {
    "Fields": {
      "keys": [
        'assistants_id',
        'tags_id',
        'index_tags_assistants_on_assistants_id',
        'index_tags_assistants_on_tags_id',
        'create_table "tags_contents"'
      ]
    }
  },
  "tags_contents": {
    "Fields": {
      "keys": [
        'contents_id',
        'tags_id',
        'index_tags_contents_on_contents_id',
        'index_tags_contents_on_tags_id',
        'create_table "tags_recipes"'
      ]
    }
  },
  "tags_recipes": {
    "Fields": {
      "keys": [
        'recipes_id',
        'tags_id',
        'index_tags_recipes_on_recipes_id',
        'index_tags_recipes_on_tags_id'
      ]
    }
  },
  "User": {
    "Fields": {
      "keys": [],
    }
  }
};