# Homey Tech Test

## Task

Use Ruby on Rails to build a project conversation history. A user should be able to:

- leave a comment
- change the status of the project

The project conversation history should list comments and changes in status. 

Please don’t spend any more than 3 hours on this task.

## Brief

Treat this as if this was the only information given to you by a team member, and take the approach you would normally take in order to build the right product for the company.

To this extent:

- Please write down the questions you would have asked your colleagues
- Include answers that you might expect from them
- Then build a project conversation based on the answers to the questions you raised.

## Tech
- Ruby 3.2.1
- Rails 7.0.4.2
- Postgresql 1.1
- RSpec
- Rubocop
- Statesman
- Devise
- Bootstrap

## Setup
First clone the repository. Once cloned, run `bundle` to install the Gems. Next set up the database:

`rails db:create db:schema:load db:seed`

This will set up the development and test databases and set up two users:

```
Email: test@test.com
Password: 123456
```
```
Email: test2@test.com
Password: 123456
```
These users will allow you to use the application and simulate a conversation about a project.

## Usage
In the console run `rails s` to boot your local server. You can then visit `localhost:3000` to use the system. From here you may create projects, change their status and leave comments.

## Testing
The application was developed with TDD. To run the test suite (unit tests), use `rspec` in the console. The test files are located in the `spec` directory.

## Assumtions
I made several assumtions during the development process, including:
- What states can a Project be in?
  - Draft, Active, On hold, Complete, Cancelled
- Are there any restrictions when changing a Project's status?
  - Draft cannot transition to Completed
  - Cancelled can only transition to Draft
  - Complete can only transition to Active
- Can comments be edited or deleted?
  - No
- Should users have roles, such as Admin, Manager, User?
  - Yes (future improvement)

## Future Improvements
1. More testing (Controller tests and Feature tests)
2. Assign User to Project state transitions
3. Add roles and permissions to users
4. Add in-line status changes on Project page, instead of just on edit form
5. Update to a more sophisticated UI/Design
6. User management, or perhaps Single Sign-On
