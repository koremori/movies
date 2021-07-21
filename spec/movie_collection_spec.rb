# frozen_string_literal: true

RSpec.describe MovieCollection do
  let(:movie_data) { MovieCollection.new('/home/koremori/project/movies/spec/example/movies_data_example.txt') }

  context 'initialize' do
    it 'returns class instance' do
      expect(movie_data.all.first.class).to eq(ModernMovie)
      expect(movie_data.all.first.link).to eq('http://imdb.com/title/tt0111161/?ref_=chttp_tt_1')
      expect(movie_data.all.first.genre).to eq(['Crime', 'Drama'])
      expect(movie_data.all.first.rating).to eq('*************')
      expect(movie_data.all.first.premiere).to eq('October-14-1994')
    end
  end

  context 'sort_by' do
    it 'sorts movies by any given key' do
      expect(movie_data.sort_by(:rating).last.rating).to eq('*************')
    end
  end

  context 'filter' do
    it 'searches desired movie by filtering the stack' do
      expect(movie_data.filter(:origin, 'Australia').first.origin).to eq('Australia')
    end
  end

  context 'stats' do
    it 'shows whole quantity of matches' do
      expect(movie_data.stats(:genre)).to eq({ 'Action' => 1,
                                               'Adventure' => 1,
                                               'Comedy' => 1,
                                               'Crime' => 2,
                                               'Drama' => 3,
                                               'Horror' => 1,
                                               'Mystery' => 2,
                                               'Romance' => 1,
                                               'Sci-Fi' => 3,
                                               'Thriller' => 1,
                                               'War' => 1 })
    end
  end
end
