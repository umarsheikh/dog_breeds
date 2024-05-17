FROM ruby:3.3.1

WORKDIR /app

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libsqlite3-dev \
    nodejs \
    npm

RUN npm install -g yarn

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

EXPOSE 3000

ENTRYPOINT ["./entrypoint.sh"]

CMD ["rails", "server", "-b", "0.0.0.0"]
