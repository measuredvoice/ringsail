class ServiceBinding
  def initialize(service, uri)
    @service = service
    @uri = uri
  end

  ## instance methods

  def shortname
    @service.shortname.to_sym
  end

  def longname
    @service.longname
  end

  def display_name
    @service.display_name_eval.gsub('<account>', account)
  end

  def service_url_example
    @service.service_url_example
  end

  def service_url_canonical
    # By default, return whatever the user specified.
    @service.service_url_canonical_eval.gsub('<account>', account)
  end

  def account
    account_id = nil
    matchers = @service.account_matchers_eval
    if matchers
      if nil_matcher = matchers[:nil]
        return nil if nil_matcher.to_regexp =~ @uri.path
      end

      if host_matcher = matchers[:host]
        account_id = host_matcher.to_regexp.match(@uri.host).try(:[], :id)
      end

      if account_id.nil? and path_matcher = matchers[:path]
        account_id = path_matcher.to_regexp.match(@uri.path).try(:[], :id)
      end

      if account_id.nil? and fragment_matcher = matchers[:fragment]
        account_id = fragment_matcher.to_regexp.match(@uri.fragment || @uri.path).try(:[], :id)
      end

      if account_id.nil? and cond_matcher = matchers[:conditional]
        if_regex = cond_matcher[:if].to_regexp
        then_regex = cond_matcher[:then].to_regexp
        else_regex = cond_matcher[:else].to_regexp

        if if_regex =~ @uri.path
          account_id = then_regex.match(@uri.path).try(:[], :id)
        else
          account_id = else_regex.match(@uri.path).try(:[], :id)
        end
      end
    end
    # if stop_words = matchers[:stop_words]
    #   puts stop_words.inspect
    #   puts account_id
    #   if stop_words.any? { |stop_word| account_id == stopword }
    #     account_id = nil
    #   end
    # end

    account_id || nil
  end

  #not sure if invoked?
  def uri=(uri)
    @service_uri = uri
  end
end
