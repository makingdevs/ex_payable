use Mix.Config

# You can also configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"

config :ex_payable, merchant_id: System.get_env("OPENPAY_MERCHANT_ID")
config :ex_payable, api_key: System.get_env("OPENPAY_API_KEY")
config :ex_payable, api_base_url: System.get_env("OPENPAY_API_BASE_URL")