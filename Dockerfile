# Use the official Ruby image with Ruby 3.3.1 as base
FROM ruby:3.3.1

# Set working directory inside the container
WORKDIR /app

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Copy Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the rest of the application code
COPY . .

# Expose port 3000
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
