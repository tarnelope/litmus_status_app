# Litmus Status App - To-Dos

### Tests
* StaticPagesController requires testing. Ex:
```
require "spec_helper"

describe StaticPagesController do
  render_views

  describe "#about" do
    subject do
      get :about
      response
    end

    it { should be_success }
    its(:body) { should include("Litmus Status Page") }
    it { should render_template("static_pages/index") }
  end
end
```
* StaticPageHelper spec
* Test for error messages and failing cases
* Front-end testing, functional testing i.e. Capybara
* Add seeds.rb data

### Code Improvements
* Remove or refactor UPDATE/PUT endpoint for Status
* Nest params ex: `{ status: { current_status: "UP"} }`

### Features & Design Improvements
* Authentication so only authorized users can update the status and add messages
  * Create User model
  * Setup auth
    * Devise + Simple Token Authentication
    * Adding `http_basic_authenticate_with name: "admin", password: "secret"` to controllers
    * Create ApiKey model with `SecureRandom.hex` and check it with a `before_filter` that uses `authenticate_request_with_http_token` block which will accept the token in the header of the request
    * JWT using Knock gem
* Timezone management
* Security - I removed a few built-in security features to get it working and never reimplemented them
* Subscription - email/text/notify users whenever the status changes
* Cluster status messages by date
  * Extend this to include means to search prior messages, either by content or by date
* Add more attributes to StatusMessages such as title, description
  * Better coupling between the Status and StatusMessage? So users can better understand which Status a StatusMessage is referring to. Shared attributes could include severity (partial/major outage), type of update (ex: resolving an issue, newly reporting an issue), products effected, etc.
  * Status to expand and include Up/Operational, Down, Degraded Performance
* Regional statuses
* Historic data on up time and turn around time
* Easy to access support links and info


### Naming Improvements
* **StaticPagesController** - StaticPagesController typically denotes static content pages such as Help/About/Contact. Wouldn't be as fitting if we were to add interactive functionality to the status page.
* **Status.current_status** - Status.indicator might work better? Perhaps Status.is_up = boolean, but unsure if status will always be binary.
