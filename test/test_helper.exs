ExUnit.start

dan = %Oprah.User{id: "dan", gitlab_id: 1, name: "dan"}
Oprah.Image.user_upsert_by_gitlab_id(dan)
don = %Oprah.User{id: "don", gitlab_id: 2, name: "don"}
Oprah.Image.user_upsert_by_gitlab_id(don)
ron = %Oprah.User{id: "ron", gitlab_id: 2, name: "ron"}
Oprah.Image.user_upsert_by_gitlab_id(ron)
