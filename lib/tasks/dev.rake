namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD ... ")  { %x(rails db:drop) }
      
      show_spinner("Criando DB ... ") { %x(rails db:create) }
    
      show_spinner("Migrando DB ... ") { %x(rails db:migrate) }

      %x(rails dev:add_coins)
      %x(rails dev:add_mining_types) 
        
    else
      puts "Você não esta em ambiente de desenvolvimento!"
  end
end

  desc "Cadastra as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas ... ") do
  coins = [
    {
        description: "Bitcoin",
        acronym: "BTC",
        url_image: "https://www.capital21.io/assets/btc-coin-42133dbc776dd0cfaae06b544c4dd94a3173c3e59862192850bbc5ddbe8bce66.png"
            },
        
            {
                description: "Ethereum",
                acronym: "ETH",
                url_image: "https://marcas-logos.net/wp-content/uploads/2020/03/ETHEREUM-LOGO.png"
            },
            
            {
                description: "Dash",
                acronym: "DASH",
                url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/131.png"
            },
            
            {
                description: "Dogecoin",
                acronym: "DOGE",
                url_image: "https://upload.wikimedia.org/wikipedia/pt/d/d0/Dogecoin_Logo.png"
            }
        ]
        
        coins.each do |coin|
            Coin.find_or_create_by!(coin)
          end
        end
      end

      desc "Cadastra os tipos de mineraçoes"
      task add_mining_types: :environment do
        show_spinner("Cadastrando tipos de mineraçoes ... ") do
        mining_types = [

          {
            description: "Proof of Work", 
            acronym: "PoW"
          },

          {
            description: "Proof of Stake", 
            acronym: "PoS"
          },

          {
            description: "Proof of Capacity", 
            acronym: "Poc"
          }

        ]

        mining_types.each do |mining_type|
          MiningType.find_or_create_by!(mining_type)
        end
      end
    end
        
private

def show_spinner(msg_start, msg_end = "Concluído")
      spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
      spinner.auto_spin
      yield
      spinner.success("(#{msg_end})")
    end
  end