FROM ruby:3.3.0-alpine3.18 as builder

RUN apk add --no-cache --update build-base bash libpq-dev

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

FROM builder as runner

COPY . .

EXPOSE 9292
CMD ["bundle", "exec", "puma"]

