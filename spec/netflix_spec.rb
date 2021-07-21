# frozen_string_literal: true

RSpec.describe Netflix do
  let(:netflix) { Netflix.new('/home/koremori/project/movies/spec/example/movies_data_example.txt') }

  context 'initialize' do
    it 'returns class instance' do
      expect(netflix.wallet).to eq(0)
      expect(netflix.all.first.class).to eq(ModernMovie)
    end
  end

  context 'pay' do
    it 'adds money to wallet' do
      expect { netflix.pay(20) }.to change { netflix.wallet }.from(0).to(20)
    end
  end

  context 'balance' do
    before { netflix.pay(5) }
    it 'shows current balance' do
      expect { netflix.balance }.to output("Balance: #{netflix.wallet}\n").to_stdout
    end
  end

  context 'show' do
    context 'success' do
      before { netflix.pay(15) }
      it 'chooses random movie by passed genre and historical period' do
        expect { netflix.show('Sci-Fi', :new) }.to output("Now showing: #{netflix.all[4].info} (Start time: #{Time.new.strftime('%H:%M')}, End time: #{(Time.new + (netflix.all[4].runtime * 60)).strftime('%H:%M')})\n").to_stdout
        expect { netflix.show('Sci-Fi', :ancient) }.to output("Now showing: #{netflix.all[3].info} (Start time: #{Time.new.strftime('%H:%M')}, End time: #{(Time.new + (netflix.all[3].runtime * 60)).strftime('%H:%M')})\n").to_stdout
        expect { netflix.show('Crime', :modern) }.to output("Now showing: #{netflix.all[0].info} (Start time: #{Time.new.strftime('%H:%M')}, End time: #{(Time.new + (netflix.all[0].runtime * 60)).strftime('%H:%M')})\n").to_stdout
        expect { netflix.show('Thriller', :classic) }.to output("Now showing: #{netflix.all[1].info} (Start time: #{Time.new.strftime('%H:%M')}, End time: #{(Time.new + (netflix.all[1].runtime * 60)).strftime('%H:%M')})\n").to_stdout
        expect { netflix.show('Drama', :classic) }.to output("Now showing: #{netflix.all[2].info} (Start time: #{Time.new.strftime('%H:%M')}, End time: #{(Time.new + (netflix.all[2].runtime * 60)).strftime('%H:%M')})\n").to_stdout
      end
    end

    context 'failure' do
      before { netflix.pay(3) }
      it 'fails due to insufficient funds' do
        expect { netflix.show('Sci-Fi', :new) }.to raise_error(StandardError)
      end
    end
  end

  context 'how_much?' do
    it 'displays cost of particular movie' do
      expect { netflix.how_much?('Vertigo') }.to output("Vertigo costs: #{netflix.all[1].class::COST}\n").to_stdout
    end
  end
end
