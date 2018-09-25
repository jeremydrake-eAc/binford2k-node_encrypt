Puppet::Type.type(:node_encrypted_file).provide(:ruby) do
  desc 'Ruby provider for the node_encrypted_file type'

  def exists?
    File.file?(resource[:path])
  end

  def create
    File.open(resource[:path], "w", 0600) {|f|
      f.write(resource[:content].decrypted_value)
    }
  end

  def destroy
    true
  end

  def content
    Puppet_X::Binford2k::NodeEncrypt::Value.new(File.read(resource[:path]))
  end

  def content=(value)
    File.open(resource[:path], "w", 0600) {|f|
      f.write(resource[:content].decrypted_value)
    }
  end
end
