RSpec.configure do |config|
  # Example: it 'some description', cassette: 'path/to/cassete'
  config.before(:each, :cassette) do |example|
    postfix_path = "#{example.metadata[:cassette]}.cassette"
    file_path = File.join('spec', 'fixtures', postfix_path)

    begin
      content = File.read(file_path)

      sock_double = double(Net::Telnet, cmd: content)
      allow(Net::Telnet).to receive(:new).and_return(sock_double)
    rescue Errno::ENOENT
      allow_any_instance_of(Net::Telnet).to receive(:cmd).and_wrap_original do |cmd_method, args|
        cmd_method.call(args).tap do |result|
          File.open(file_path, 'w') do |f|
            f.write(result)
          end
        end
      end
    end
  end
end
