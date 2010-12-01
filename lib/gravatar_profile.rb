require 'digest/md5'
require 'net/http'
require 'uri'
require 'xmlsimple'

class GravatarProfile
  DefaultOptions =   {
      :rating => 'PG',
      :secure => false,
      :filetype => :png,
      :size => 80
  }
  
  def gravatar_abbreviations
  { :size => 's',
    :default => 'd',
    :rating => 'r'
  }
  end
  
  
  attr_accessor :email, :id
  
  def initialize(email = '', options = {})
    
    @email = email
    @id = gravatar_id
    
  end
  
  def gravatar_id
      Digest::MD5.hexdigest(email.to_s.downcase)
  end
  
  # Constructs the full Gravatar url.
  def gravatar_url(options={})
    options = GravatarProfile::DefaultOptions.merge(options)
    gravatar_hostname(options.delete(:secure)) +
      gravatar_filename(options.delete(:filetype)) +
      url_params_from_hash(options)
  end
    
  # Constructs the full Gravatar url.
  def gravatar_profile_url(options={})
    options = GravatarProfile::DefaultOptions.merge(options)
    gravatar_hostname(options.delete(:secure)) +
      gravatar_profilename(options.delete(:filetype))
  end
  
  def get_profile_info(options={})
    options = GravatarProfile::DefaultOptions.merge(options)
    proxy_host = options.delete(:proxy_host)
    proxy_port = options.delete(:proxy_port)
    
    url = URI.parse("http://en.gravatar.com")
    res = Net::HTTP::Proxy(proxy_host, proxy_port).start(url.host, url.port) {|http|
    http.get(gravatar_profilename(:xml))
    }
    
    if res.msg == "OK"
      profile_data = XmlSimple.xml_in(res.body)
      if profile_data["entry"]
        return profile_data["entry"].first
      end
    end
  end

private
  
  # Creates a params hash like "?foo=bar" from a hash like {'foo' => 'bar'}.
  # The values are sorted so it produces deterministic output (and can 
  # therefore be tested easily).
  def url_params_from_hash(hash)
    '?' + hash.map do |key, val|
      [gravatar_abbreviations[key.to_sym] || key.to_s, val.to_s ].join('=')
    end.sort.join('&')
  end

  # Returns either Gravatar's secure hostname or not.
  def gravatar_hostname(secure)
    'http' + (secure ? 's://secure.' : '://') + 'gravatar.com'
  end
  
  # Joins the ID and the filetype into one. Like "profile.png"
  def gravatar_filename(filetype)
    "/avatar/#{gravatar_id}.#{filetype}"
  end

  def gravatar_profilename(filetype)
    if filetype
      "/#{gravatar_id}.#{filetype}"
    else
      "/#{gravatar_id}"
    end
  end
end