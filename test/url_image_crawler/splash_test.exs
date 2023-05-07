defmodule UrlImageCrawler.SplashTest do
  use ExUnit.Case

  import Mox
  alias UrlImageCrawler.Splash

  describe "fetch/1" do
    setup :verify_on_exit!

    @success_html_response ~s(
      <html>
      <body>
        <h1> links! </h1>
        <a href="http://example.com">example.com</a>
        <a href="http://example.com/1">example.com/1</a>
        <a href="http://example.com/2">example.com/2</a>

        <h1> images! </h1>
        <img src="http://example.com/1.png" />
        <img src="http://example.com/2.png" />
        <img src="http://example.com/3.png" />
      </body>
    </html>
    )

    test "success: returns a ok tuple with the images and link list" do
      url = "http://example.com"

      expect(UrlImageCrawler.Splash.ClientMock, :get, 1, fn ^url ->
        {:ok, @success_html_response}
      end)

      expected_links = ["http://example.com", "http://example.com/1", "http://example.com/2"]

      expected_images = [
        "http://example.com/1.png",
        "http://example.com/2.png",
        "http://example.com/3.png"
      ]

      assert {:ok, {^expected_links, ^expected_images}} = Splash.fetch(url)
    end
  end
end
