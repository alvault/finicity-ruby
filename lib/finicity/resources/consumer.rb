module Finicity
  module Resources
    class Consumer < Base

      # E.g. Finicity::Client.scope(10001).consumer.create({...})
      # Look at https://community.finicity.com/s/article/Report-Consumers#create_consumer for required body options
      def create(body)
        request(:post, "/decisioning/v1/customers/#{customer_id}/consumer", body: body)
      end

      # E.g. Finicity::Client.scope(10001).consumer.get
      def get
        request(:get, "/decisioning/v1/customers/#{customer_id}/consumer")
      end

      # E.g. Finicity::Client.scope(10001).consumer.get_connect_link(
      #        partner_id: 1111,
      #        type: 'aggregation',
      #        redirect_uri: 'https://example.com/redirect'
      #      )
      def get_connect_link(
        partner_id:,
        type:nil,
        redirect_uri:,
        webhook: nil,
        webhook_content_type: nil,
        institution_settings: nil,
        is_iframe: false,
        experience: "default"
      )
        body = {
          customerId: customer_id.to_s,
          partnerId: partner_id.to_s,
          experience: experience
        }

        body[:type] = type if type
        body[:redirectUri] = redirect_uri if is_iframe
        body[:webhook] = webhook if webhook
        body[:webhookContentType] = webhook_content_type if webhook_content_type

        body[:institutionSettings] = institution_settings if institution_settings

        request(:post, '/connect/v2/generate', body: body)
      end
    end
  end
end
