# frozen_string_literal: true

RSpec.describe Movie do
  let(:movie_data) do
    ['http://imdb.com/title/tt0993846/?ref_=chttp_tt_140',
     'The Wolf of Wall Street',
     '2013',
     'USA',
     'December-25-2013',
     'Biography,Comedy,Crime',
     '180',
     '8.1',
     'Martin Scorseze',
     'Leonardo DiCaprio, Jonah Hill, Margot Robbie']
  end

  context 'initialize' do
    context 'success' do
      it 'returns class instance' do
        movie = Movie.new(movie_data)
        expect(movie.link).to eq('http://imdb.com/title/tt0993846/?ref_=chttp_tt_140')
        expect(movie.genre).to eq(['Biography', 'Comedy', 'Crime'])
        expect(movie.rating).to eq('*')
        expect(movie.premiere).to eq('December-25-2013')
      end
    end

    context 'failure' do
      it 'fails to initialize' do
        expect { Movie.new('') }.to raise_error(ArgumentError)
      end
    end
  end

  context 'has_genre?' do
    let(:movie) { Movie.new(movie_data) }

    context 'valid genre' do
      it 'returns true' do
        expect(movie.has_genre?('Comedy')).to eq(true)
      end
    end

    context 'invalid genre' do
      it 'returns false' do
        expect { movie.has_genre?('Tragedy') }.to raise_error(ArgumentError)
      end
    end
  end

  context 'normalizing_dates' do
    let(:date) { '2013' }

    context 'date with 4 digits' do
      it 'adds blank digits to pass unification' do
        expect(normalizing_dates(date)).to eq('2013-01-01')
      end
    end

    let(:date) { '1959-09' }
    context 'date with 7 digits' do
      it 'adds blank digits to pass unification' do
        expect(normalizing_dates(date)).to eq('1959-09-01')
      end
    end
  end
end
