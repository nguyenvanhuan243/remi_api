# Use the official Ruby image from Docker Hub
FROM ruby:2.6.8

# Set the working directory in the container
WORKDIR /app

# Install bundler
RUN gem install bundler -v '2.4.7'

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install dependencies
RUN bundle install

# Copy the rest of the application code into the container
COPY . .

# Expose port 3001 to the Docker host, so you can access it from the outside
EXPOSE 3001

# Command to run the Rails server
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3001"]
