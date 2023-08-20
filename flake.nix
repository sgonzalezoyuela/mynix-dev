{
  description = "My DEV templates";

  outputs = { self, ... }: {
    templates = {
      java8 = {
        path = ./java8;
        description = "Java8 w/Maven";
      };
      josso = {
        path = ./josso;
        description = "JOSSO w/JDK8";
      };
    };
  };
}
