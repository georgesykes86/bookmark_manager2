describe DatabaseMapper do

  let(:connection) { spy :db_connection }
  let(:bookmark_class) { spy :bookmark_class }
  subject(:db_mapper) { described_class.new(connection, bookmark_class) }

  context '#add_bookmark' do
    it 'adds a url to the array of bookmarks' do
      url, title = 'http://thoughtbot.com', 'thoughtbot'
      insert = "INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}') RETURNING id, url, title;"
      allow(connection).to receive(:query).with(insert)
        .and_return(["first item"])
      allow(bookmark_class).to receive(:new).with(anything)
      db_mapper.add_bookmark(url, title)
      expect(bookmark_class).to have_received(:new).with("first item")
      expect(connection).to have_received(:query).with(insert)
    end

    it 'does not add an incorrect url' do
      db_mapper.add_bookmark('not a valid url')
      expect(connection).not_to have_received(:query)
    end

  end

  describe '#delete' do
    it 'deletes a bookmark' do
      id, table_name = 1, 'bookmarks'
      delete = "DELETE FROM #{table_name} WHERE id=#{id}"
      allow(connection).to receive(:query).with(delete)
      db_mapper.delete(id, table_name)
      expect(connection).to have_received(:query).with(delete)
    end
  end


  describe '#find_bookmark' do
    it 'finds bookmark by id' do
      id = '2'
      find = "SELECT * FROM bookmarks WHERE id='#{id}'"
      allow(connection).to receive(:query).with(find)
        .and_return(["first item"])
      allow(bookmark_class).to receive(:new).with(anything)
      db_mapper.find_bookmark(id)
      expect(bookmark_class).to have_received(:new).with("first item")
      expect(connection).to have_received(:query).with(find)
    end
  end

  describe "#update" do
    it 'updates bookmark by title' do
      id, title, url = 1, 'fake_title', 'http://thoughtbot.com'
      update = "UPDATE bookmarks SET url='#{url}',title='#{title}' WHERE id=#{id}"
      db_mapper.update_bookmark(id, title, url)
      expect(connection).to have_received(:query).with(update)
    end

    it 'returns false if url is not valid' do
      db_mapper.update_bookmark(1, 'title','not a valid url')
      expect(connection).not_to have_received(:query)
    end
  end


end
