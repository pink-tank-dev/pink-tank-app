require 'rails_helper'

RSpec.describe "Api::V1::Artworks#acquire", type: :request do
  describe "POST /api/v1/artworks/:id/acquire" do
    let(:artwork) { create(:artwork) }

    before { post "/api/v1/artworks/#{artwork.id}/acquire", params: acquire_params }

    context "when shipping" do
      context "and when paying in installments" do
        context "and all information is correctly provided" do
          let(:acquire_params) do
            {
              acquire: {
                delivery_method: "shipping",
                payment_method: "installments",
                name: Faker::Name.name,
                email: Faker::Internet.email,
                phone: Faker::PhoneNumber.phone_number,
                address_1: Faker::Address.street_address,
                address_2: Faker::Address.secondary_address,
                city: Faker::Address.city,
                postal_code: Faker::Address.postcode,
                state: Faker::Address.state,
                country: Faker::Address.country
              }
            }
          end
  
          it { expect(response.status).to eq(204) }
        end

        context "and information is not fully provided" do
          
        end
      end

      context "and when buying now" do
        context "and all information is correctly provided" do
          let(:acquire_params) do
            {
              acquire: {
                delivery_method: "shipping",
                payment_method: "buy_now",
                name: Faker::Name.name,
                email: Faker::Internet.email,
                phone: Faker::PhoneNumber.phone_number,
                address_1: Faker::Address.street_address,
                address_2: Faker::Address.secondary_address,
                city: Faker::Address.city,
                postal_code: Faker::Address.postcode,
                state: Faker::Address.state,
                country: Faker::Address.country
              }
            }
          end
  
          it { expect(response.status).to eq(204) }
        end

        context "and information is not fully provided" do
          
        end
      end
    end

    context "when picking up" do
      context "and when paying in installments" do
        context "and all information is correctly provided" do
          let(:acquire_params) do
            {
              acquire: {
                delivery_method: "pickup",
                payment_method: "installments",
                email: Faker::Internet.email,
                phone: Faker::PhoneNumber.phone_number
              }
            }
          end
  
          it { expect(response.status).to eq(204) }
        end
      end

      context "and when buying now" do
        context "and all information is correctly provided" do
          let(:acquire_params) do
            {
              acquire: {
                delivery_method: "pickup",
                payment_method: "installments",
                email: Faker::Internet.email,
                phone: Faker::PhoneNumber.phone_number
              }
            }
          end
  
          it { expect(response.status).to eq(204) }
        end
      end
    end

    context "when delivery method is incorrectly defined" do
      let(:acquire_params) do
        { 
          acquire: {
            delivery_method: "fedex"
          }
        }
      end

      it { expect(response.status).to eq(400) }
      it { expect(json["message"]).to eq("Delivery method not specified: ['shipping', 'pickup']") }
    end

    context "when payment method is incorrectly defined" do
      let(:acquire_params) do
        {
          acquire: {
            delivery_method: "shipping",
            payment_method: "credit_card"
          }
        }
      end

      it { expect(response.status).to eq(400) }
      it { expect(json["message"]).to eq("Payment method not specified: ['installments', 'buy_now']") }
    end
  end
end
