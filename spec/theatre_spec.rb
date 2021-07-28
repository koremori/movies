# frozen_string_literal: true

RSpec.describe Theatre do
  let(:theatre) { Theatre.new('/home/koremori/project/movies/spec/example/movies_data_example.txt') }
  context 'initialize' do
    it 'returns class instance' do
      expect(theatre.all.first.class).to eq(ModernMovie)
    end
  end

  context 'show' do
    context 'chooses one movie from predefined set' do

      context 'Morning session' do
        it 'shows movies at the box office in the morning' do
          expect(theatre.show(8).first.class).to eq(AncientMovie)
        end
      end

      context 'Afternoon session' do
        it 'shows movies at the box office in the afternoon' do
          srand 0
          movie1 = theatre.show(14)
          srand 1
          movie2 = theatre.show(14)
          srand 2
          movie3 = theatre.show(14)
          expect(movie1).not_to eq(movie2)
          expect(movie2).not_to eq(movie1)
          expect(movie3).not_to eq(movie2)
        end
      end

      context 'Evening session' do
        it 'shows movies at the box office in the evening' do
          srand 0
          movie1 = theatre.show(22)
          srand 1
          movie2 = theatre.show(22)
          srand 3
          movie3 = theatre.show(22)
          expect(movie1).not_to eq(movie2)
          expect(movie2).not_to eq(movie1)
          expect(movie3).not_to eq(movie2)
        end
      end
    end
  end

  context 'when?' do
    context 'Morning session' do
      it 'outputs morning time movies' do
        expect { theatre.when?('Metropolis') }.to output("Metropolis will be shown in the morning\n").to_stdout
      end
    end

    context 'Afternoon session' do
      it 'outputs afternoon time movies' do
        expect { theatre.when?('Mad Max') }.to output("Mad Max will be shown in the afternoon\n").to_stdout
        expect { theatre.when?('Dr. Strangelove or: How I Learned to Stop Worrying and Love the Bomb') }.to output("Dr. Strangelove or: How I Learned to Stop Worrying and Love the Bomb will be shown in the afternoon\n").to_stdout
      end
    end

    context 'Evening session' do
      it 'outputs evening time movies' do
        expect { theatre.when?('The Thing') }.to output("The Thing will be shown in the evening\n").to_stdout
        expect { theatre.when?('The Shawshank Redemption') }.to output("The Shawshank Redemption will be shown in the evening\n").to_stdout
        expect { theatre.when?('Vertigo') }.to output("Vertigo will be shown in the shadow realm\n").to_stdout
      end
    end
  end
end
