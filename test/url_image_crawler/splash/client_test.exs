defmodule UrlImageCrawler.Splash.ClientTest do
  use ExUnit.Case

  setup_all do
    {:ok, bypass: Bypass.open()}
  end

  setup [:set_splash_url]

  describe "get/1" do
    test "success: make a 200 request with the required params", %{bypass: bypass} do
      url = "http://example.com"

      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/render.html"
        assert conn.query_params == %{"render_all" => "1", "url" => url, "wait" => "5.5"}

        Plug.Conn.resp(conn, 200, "body")
      end)

      assert {:ok, "body"} = UrlImageCrawler.Splash.Client.get(url)
    end
  end

  defp set_splash_url(%{bypass: bypass}) do
    splash_url = "http://localhost:#{bypass.port}/"
    Application.put_env(:url_image_crawler, :splash_url, splash_url)
  end
end
