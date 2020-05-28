# ParallelMarkets Coding Challenge

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

The new investor form is at "/".  File uploads are stored at `uploads` directory at theroot of this project.

## New Investor Creation Application

### Architecture

#### Database tables

`users`: has_one `investor`, has_many `uploads`
  - first_name
  - last_name
  - dob
  - phone
  - address
  - state
  - zip

`investors`: belongs_to `user`
  - user_id

`uploads`: belongs_to `user`
  - fileaname
  - size
  - content_type
  - user_id

#### Phoenix architecture

The app is called ParallelMarkets and has three contexts
  - `Accounts` which just has an `User` schema
  - `MarketPlace` which has an `Investor` schema 
    - `User` and `Investor` have a 1-to-1 relationship. The idea is an Investor is a "type" of User.  We put all the attributes that are universal to all users of the system in User and for any attributes that are exclusive to Investors we place there.  In this case, it happens that all the required specified attributes seem to to belong in User so Investor only has a user_id to relate it to it's User.  In the future, if we find investors need something like an investment account number, that would go in the Investor schema.  In this way, we have a specialized schema for each type of user in our system (others could be Partner, Admin, etc.) 
  - `Documents` which has an `Upload` schema to store our uploaded file information.

The only controller is `investor_controller` which has `new` and `create` actions to render our new investor form and create one upon submit.

And last is the corresponding `investor` view and template for the form itself.

The path where uploads are stored on the server is set in `config/dev` as `parallel_markets.uploads_directory`

### Done 

- All basic functionality works. At `localhost:4000`, a new investor form is shown where upon you enter 
  investor info and select a file to upload. Upon submission, a success alert is shown, the file is saved
  to the server's file system and a new form is shown ready to create another investor.
- Error reporting for empty form fields
- Increased max upload file size to 20MB

### Things I would have like to do/fix if more time

- I took a shortcut for handling the error alert when the user submits without an upload file. See the comment at `MarketPlace#create_investor` for details 
- Tests.  Didn't time to do any.  Very important. 
- Implement the frontend with [`Phoenix LiveView`](https://github.com/phoenixframework/phoenix_live_view). SPA-like UI with no JavaScript ftw!



