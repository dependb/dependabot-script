FROM dependabot/dependabot-core:0.172.1 as dependabot-script-base

ARG CODE_DIR=/home/dependabot/dependabot-script
RUN mkdir -p ${CODE_DIR}
COPY --chown=dependabot:dependabot Gemfile Gemfile.lock ${CODE_DIR}/
WORKDIR ${CODE_DIR}
RUN bundle config set --local path "vendor" \
  && bundle install --jobs 4 --retry 3

COPY --chown=dependabot:dependabot . ${CODE_DIR}

FROM dependabot-script-base as dependabot-script

# CMD ["bundle", "exec", "ruby", "./generic-update-script.rb"]