require 'bookmark_factory'

describe BookmarkFactory do
  it 'returns an array of bookmarks' do
    expect(subject.all).to be_an_instance_of Array
  end

end
