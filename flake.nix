{
  description = "A collection of flake templates";

  outputs = { ... }: {
    templates = {

      androidSDK = {
        path = ./android-sdk;
        description = "Dev shell including the android SDK";
      };

    };
  };
}
