class RspecCassete
  UnexpectedCassetteArgs = Class.new(StandardError)

  attr_reader :file_path

  def initialize(rspec_example)
    postfix_path = "#{rspec_example.metadata[:cassette]}.yaml"
    @file_path = File.join('spec', 'fixtures', postfix_path)
  end

  def exists?
    File.file?(file_path)
  end

  def cmd(args)
    cassette = YAML.load_file(file_path)

    cassette.each do |request|
      next unless request[:args] == args

      return request[:content]
    end

    raise(UnexpectedCassetteArgs, args)
  end

  def wrapper(cmd_method, args)
    @requests ||= []

    cmd_method.call(args).tap do |result|
      @requests << {
          args: args,
          content: result
      }
    end
  end

  def commit!
    return if !@requests || @requests.empty?

    File.open(file_path, 'w') do |f|
      f.write(@requests.to_yaml)
    end
  end
end

RSpec.configure do |config|
  # Example: it 'some description', cassette: 'path/to/cassete'
  config.before(:each, :cassette) do |example|
    @cassette = RspecCassete.new(example)

    if @cassette.exists?
      sock_double = double(Net::Telnet, close: 'close')
      allow(sock_double).to receive(:cmd, &@cassette.method(:cmd))

      allow(Net::Telnet).to receive(:new).and_return(sock_double)
    else
      allow_any_instance_of(Net::Telnet)
        .to receive(:cmd).and_wrap_original(&@cassette.method(:wrapper))
    end
  end

  config.after(:each, :cassette) do |example|
    @cassette.commit!
  end
end
