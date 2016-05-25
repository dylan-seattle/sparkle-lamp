# Miasma Google

Google API plugin for the miasma cloud library

## Supported credential attributes:

Supported attributes used in the credentials section of API
configurations:

```ruby
Miasma.api(
  :type => :orchestration,
  :provider => :google,
  :credentials => {
    ...
  }
)
```

### Credential attributes

` `google_project` - ID of the google project to use
* `google_service_account_email` - Email address for service account
* `google_service_account_private_key` - Path to private key for service account
* `google_auth_scope` - Scope requested for user (default: `'cloud-platform'`)
* `google_auth_base` - URL endpoint for authorization (default: `'https://www.googleapis.com/auth'`)
* `google_assertion_target` - URL for permission assertion (default: `'https://www.googleapis.com/oauth2/v4/token'`)
* `google_assertion_expiry` - Number of seconds token is valid (default: `120`)
* `google_api_base_endpoint` - URL for requests (default: `'https://www.googleapis.com'`)

## Current support matrix

|Model         |Create|Read|Update|Delete|
|--------------|------|----|------|------|
|AutoScale     |      |    |      |      |
|BlockStorage  |      |    |      |      |
|Compute       |      |    |      |      |
|DNS           |      |    |      |      |
|LoadBalancer  |      |    |      |      |
|Network       |      |    |      |      |
|Orchestration |  X   | X  |  X   |  X   |
|Queues        |      |    |      |      |
|Storage       |      |    |      |      |

## Info
* Repository: https://github.com/miasma-rb/miasma-google
