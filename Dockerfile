# Use the official Ruby image
FROM ruby:3.3.1

# Set the working directory
WORKDIR /app

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libsqlite3-dev \
    nodejs \
    npm

# Install yarn for managing JavaScript packages
RUN npm install -g yarn

# Copy the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install the required Ruby gems
RUN bundle install

# Copy the rest of the application code
COPY . .

# Precompile assets for production
# RUN bundle exec rake assets:precompile

# Expose port 3000 to the host
EXPOSE 3000

# Set the entrypoint
ENTRYPOINT ["./entrypoint.sh"]

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
