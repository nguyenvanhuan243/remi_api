# CircleCI is a continuous integration and continuous delivery platform that can be used to implement DevOps practices. The company was founded in September 2011 and has raised $315 million in venture capital funding as of 2021, at a valuation of $1.7 Billion. CircleCI is one of the world's most popular CI/CD platforms



# How to integrate CI to source code

# Step 1: Create folder .circleci and file config.yml
```
  mkdir .circleci
  touch config.yml
  git add .circleci
  git commit -m "integrate circleci"
  git push
```


# Sample Code For CI
```
version: 2.1
# orbs:
#   codecov: codecov/codecov@3.1.0
jobs:
  build:
    parallelism: 4
    docker:
      - image: circleci/ruby:2.6.8 # Ruby Version
        environment:
          BUNDLE_JOBS: 3
          BUNDLE_RETRY: 3
          BUNDLE_PATH: vendor/bundle
          PGHOST: 127.0.0.1
          PGUSER: bitcoin_exchange_user
          RAILS_ENV: test
          REDIS_URL: redis://localhost:6379
          SECRET_KEY_BASE: db9f771130e52a01b1c243a02218eebe755c3d1f00e277213ede177107f0bc47380e1fecbb30dd1e64184ed4ab601ef3bf0c470cc7e06dcdf404c2dcf181d645
      - image: circleci/postgres:12.4
        environment:
          POSTGRES_USER: bitcoin_exchange_user
          POSTGRES_DB: bitcoin_database_test
          POSTGRES_HOST_AUTH_METHOD: trust
      - image: cimg/redis:6.2.6
    steps:
      - checkout
      - run: sudo apt-get update --allow-releaseinfo-change
      - run: sudo apt install -y postgresql-client || true
    # Install bundler
      - run:
          name: Install latest Bundler
          command: gem install bundler:2.4.6
        
    #  Which version of bundler?
      - run:
          name: Which bundler?
          command: bundle -v

      # Restore bundle cache
      - restore_cache:
          keys:
            - rails-bundle-v2-{{ checksum "Gemfile.lock" }}
            - rails-bundle-v2-

      - run:
          name: "Update bundler"
          command: bundle update --bundler
        
      - run:
          name: Bundle Install
          command: bundle check || bundle install
      - run:
          name: Install NodeJS
          command: sudo apt-get install nodejs

      # Store bundle cache
      - save_cache:
          key: rails-bundle-v2-{{ checksum "Gemfile.lock" }}
          paths:
            - vendor/bundle

      # Only necessary if app uses webpacker or yarn in some other way
      - run:

          name: install dockerize

          command: wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz && sudo tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

          environment:

            DOCKERIZE_VERSION: v0.3.0

      - run:
          name: Wait for DB
          command: dockerize -wait tcp://localhost:5432 -timeout 1m
      - run:
          name: Database setup
          command: |
            bundle exec rake db:drop RAILS_ENV=test
            bundle exec rake db:create RAILS_ENV=test
            bundle exec rake db:migrate RAILS_ENV=test
      - run:
          name: Run Tests
          command: |
            bundle exec rspec $(cat /tmp/tests-to-run)
            bundle exec rspec spec
      - store_artifacts:
          path: coverage

  deploy_production:
    machine:
      enabled: true
    steps:
      - checkout
      - run:
          name: Production Render deploying
          command: |
            curl -s "https://api.render.com/deploy/srv-cfnnp8cgqg415e3lm1hg?key=SlMHWRc3iIE"
workflows:
  version: 2
  build_and_deploy:
    jobs:
      - build:
          filters:
            branches:
              only:
                - main
      - deploy_production:
          requires:
            - build
          filters:
            branches:
              only:
                - main

```


# There are 2 workflow build and deploy_production to run

# First run build workflow
# Final run build deploy_production