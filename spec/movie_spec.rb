# frozen_string_literal: true

RSpec.describe Movie do
  let(:movie_data) do
    ['http://imdb.com/title/tt0993846/?ref_=chttp_tt_140',
     'The Wolf of Wall Street',
     '2013',
     'USA',
     '2013-12-25',
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
        expect(movie.shot).to eq(2013)
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
    let(:date1) do
      ['http://imdb.com/title/tt0052357/?ref_=chttp_tt_68',
       'Vertigo',
       '1958',
       'USA',
       '1958',
       'Mystery,Romance,Thriller',
       '128',
       '8.4',
       'Alfred Hitchcock',
       'James Stewart, Kim Novak, Barbara Bel Geddes']
    end

    context '4 digit date' do
      it 'adds numbers to unify format' do
        date_test = Movie.new(date1)
        expect(date_test.premiere).to eq('January-01-1958')
      end
    end

    context '7 digit date' do
      let(:date2) do
        ['http://imdb.com/title/tt0052561/?ref_=chttp_tt_247',
         'Anatomy of a Murder',
         '1959',
         'USA',
         '1959-09',
         'Crime,Drama,Mystery',
         '160',
         '8.1',
         'Otto Preminger',
         'James Stewart, Lee Remick, Ben Gazzara']
      end

      it 'adds numbers to unify format' do
        date_test2 = Movie.new(date2)
        expect(date_test2.premiere).to eq('September-01-1959')
      end
    end
  end
end
