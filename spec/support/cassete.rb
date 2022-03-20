class RspecCassete
  attr_reader :file_path

  def initialize(rspec_example)
    postfix_path = "#{rspec_example.metadata[:cassette]}.yaml"
    @file_path = File.join('spec', 'fixtures', postfix_path)
  end

  def exists?
    File.file?(file_path)
  end

  def double_args
    cassette = YAML.load_file(file_path)
    cmd = proc do |cmd_name, args|
      cassette[:args] == args.to_yaml
    end

    [Net::Telnet, cmd: cassette[:content]]
  end

  def wrapper(cmd_method, args)
    cmd_method.call(args).tap do |result|
      File.open(file_path, 'w') do |f|
        f.write({
          args: args,
          content: result
        }.to_yaml)
      end
    end
  end
end

RSpec.configure do |config|
  # Example: it 'some description', cassette: 'path/to/cassete'
  config.before(:each, :cassette) do |example|
    cassette = RspecCassete.new(example)

    if cassette.exists?
      sock_double = double(*cassette.double_args)
      allow(Net::Telnet).to receive(:new).and_return(sock_double)
    else
      allow_any_instance_of(Net::Telnet)
        .to receive(:cmd).and_wrap_original(&cassette.method(:wrapper))
    end
  end
end
