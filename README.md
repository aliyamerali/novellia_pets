# Novellia Pets
_Takehome for Novellia Software Engineer position_

### Technology choices
This app is built using [Ruby on Rails](https://rubyonrails.org/) (RoR). Though it's been a few years since I worked professionally in RoR, I chose this framework for the ease of setup and light-weight infrastructure in standing up a full-stack application. I lean more backend-focused, so I didn't spend much time on the frontend, aside from pure functionality.

Using the standard Rails structure, data is stored in a relational database (Postgres).

**Tech**:
* Ruby 3.2.2
* Rails 7.1.3.4
* PostgreSQL 14.12

### Local setup
**Downloads**  
If you don't already have these tools installed, here's a quick how-to with helpful links:
* [Homebrew](https://brew.sh/): 
    - Likely already installed on your machine, but just in case: 
    `$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
* Ruby:
    - Download a version manager ([rbenv](https://github.com/rbenv/rbenv)):
        - `$ brew install rbenv ruby-build`
    - Install and set up preferred ruby version:
        - `$ rbenv install 3.2.2`
        - `$ rbenv local 3.2.2`
        - `$ ruby -v` should show this version now, if not restart your terminal
* [Postgres](https://formulae.brew.sh/formula/postgresql@14):
    - `$ brew install postgresql@14`

**Run the app locally** 
- Clone this repo to your local machine: `$ git clone git@github.com:aliyamerali/novellia_pets.git`
- Run `$ bundle install` to install gems
- Run `$ rails db:{create,migrate,seed}` to setup the database, run migrations, and seed some base data
- Run `$ rails s` and navigate to [http://localhost:3000](http://localhost:3000). There are two different experiences: 
    - _Admin_: [http://localhost:3000/admin/pets](http://localhost:3000/admin/pets)
    - _User_: [http://localhost:3000/user/pick-an-id/pets](http://localhost:3000/user/pick-an-id/pets)
        - Here's a user with a few pets seeded: [http://localhost:3000/user/system/pets](http://localhost:3000/user/system/pets)

**Running Tests**
* All tests are under the `/spec` directory
* Run `$ bundle exec rspec --format documentation` in the terminal to run the full test suite. You should see an output like this: 

  <img width="667" alt="test_output" src="https://github.com/aliyamerali/novellia_pets/assets/5446926/adfee109-54e0-42af-b020-c7a9a95fffa7">



### Design decisions + notes for production
<img width="932" alt="db_schema" src="https://github.com/aliyamerali/novellia_pets/assets/5446926/0ec3a0d5-a5f2-4af4-813e-dc114bf03a5f">

* In setting up the DB schema, I considered using single-table-inheritance to store all medical records, but decided against it given the varying fields on the different medical records and the unknowns of future types of medical records. Instead, I went with multiple tables (one per type of medical record) and a shared abstract parent class that will allow all medical records to share key behaviors.
    * If we were to release a production version of the app, I'd consider other pathways to clean this up and enable easier querying across all medical records - exploring the `ActiveRecord::DelegatedType` module to see if this is a good fit.
* I made `allergy_reactions` a separate table with a many:one relationship to `allergy_records` with the thinking that one allergen may cause multiple reactions of varying severity. This leads to a slightly wonky user experience (due to my limited experience with ERB) in which a user enters the allergy and reactions in separate forms.
    * In a production release, I'd prioritize better FE tooling to improve this flow, and talk to users to get a better understanding of expected use cases for the allergy/reaction relationship.
* In an attempt to keep data as normalized as possible, I set key fields (`species`, `reaction`, `severity`) as enums. This is limiting, of course, in the data that users can enter.
    * For a real app, we could consider putting these into separate tables to allow for easier CRUD actions against them.
* I added a uniqueness validation (at the model level) on pet records across pet name, species, owner name, and DOB.
    * If we took on real users, I'd want to gain clarity on which attributes should maintain uniqueness, and enforce this with a database-level constraint.
* To enable two different user "types" (Admin vs User), I created two namespaced API routes.
    * With more time, I'd also consider creating a User model / database resource to enable a more structured experience and normalize across tables (e.g. is a user always an owner? An owner always a user?)
    * In a production release, I'd want to build in auth that would allow a more dynamic FE view based on user roles/permissions. 
<img width="1337" alt="admin_index" src="https://github.com/aliyamerali/novellia_pets/assets/5446926/ff4fc266-ced5-431d-9d4d-1887ed01710c">
<img width="1329" alt="user_index" src="https://github.com/aliyamerali/novellia_pets/assets/5446926/fe0b7267-fd76-414d-baaf-e5c1c84503a5">

### User Stories:
- As a user, I can add a new pet
- As a user, I can add a new vaccination or allergy record to my pet
- As an admin, I can see all pets added and their records
- _[bonus feature]_ As a user or an admin, I can easily identify which pets are overdue for vaccines (1 or more vaccine is >1 year old) because they are highlighted in the index view
