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
                    expect(theatre.show('morning').first.class).to eq(AncientMovie)
                end
            end

            context 'Afternoon session' do
                it 'shows movies at the box office in the afternoon' do
                    expect { theatre.show('Afternoon') }.to output("Now showing: #{theatre.all[6].info}\n").to_stdout
                    expect { theatre.show('Afternoon') }.to output("Now showing: #{theatre.all[4].info}\n").to_stdout
                    #expect(theatre.show('Afternoon').first.genre).to include(['Adventure'])
                    #expect(theatre.show('afternoon').first.genre).to eq(['Adventure'])
                end
            end

            context 'Evening session' do
                it 'shows movies at the box office in the evening' do
                    expect { theatre.show('Evening') }.to output("Now showing: #{theatre.all[5].info}\n").to_stdout
                    expect { theatre.show('Evening') }.to output("Now showing: #{theatre.all[0].info}\n").to_stdout
                    #expect(theatre.show('Evening').first.genre).to include(['Horror'])
                    #expect(theatre.show('evening').first.genre).to eq(['Horror'])
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
                expect { theatre.when?('Anatomy of a Murder') }.to output("Anatomy of a Murder will be shown in the evening\n").to_stdout
            end
        end
    end
end