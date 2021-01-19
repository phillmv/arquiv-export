# extended from the original in order to use our bespoke search path stuff
module PipelineFilter
  class MentionFilter < HTML::Pipeline::MentionFilter
    def link_to_mentioned_user(login)
      result[:mentioned_usernames] |= [login]

      "<a href='https://github.com/#{login}' class='user-mention'>" \
        "@#{login}" \
        '</a>'
    end
  end
end
