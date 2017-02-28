dns     = require 'isomorphic-dns'
_ = {
  difference:  require 'lodash/difference'
  first:       require 'lodash/first'
  map:         require 'lodash/map'
  pull:        require 'lodash/pull'
  sortBy:      require 'lodash/sortBy'
}
url     = require 'url'

class SrvFailover
  constructor: ({domain, @protocol, service}, {@dns}={}) ->
    throw new Error 'Missing required parameter: domain'   unless domain?
    throw new Error 'Missing required parameter: protocol' unless @protocol?
    throw new Error 'Missing required parameter: service'  unless service?

    @badUrls = []
    @hostname = "_#{service}._#{@protocol}.#{domain}"
    @dns ?= dns

  markBadUrl: (badUrl, {ttl}={}) =>
    @badUrls.push badUrl
    setTimeout (=> @markGoodUrl badUrl), ttl if ttl?

  markGoodUrl: (goodUrl) =>
    _.pull @badUrls, goodUrl

  resolveUrl: (callback) =>
    @dns.resolveSrv @hostname, (error, addresses) =>
      return callback error if error?

      allUrls = _.map _.sortBy(addresses, 'priority'), (address) =>
        url.format({@protocol, hostname: address.name, port: address.port})

      theUrl = _.first(_.difference(allUrls, @badUrls))
      return callback new Error('SRV record found, but contained no valid addresses') unless theUrl?
      callback null, theUrl


module.exports = SrvFailover
