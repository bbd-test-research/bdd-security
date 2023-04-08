#linhas adicionadas

@host_config
Feature: Host Configuration
  Verify that the configuration of the host and network are as expected

  @iriusrisk-open_ports
  Scenario Outline: Only the required ports should be open
    Given the target host name <host>
    When TCP ports from <startPort> to <endPort> are scanned using <threads> threads and a timeout of <timeout> milliseconds
    And the <state> ports are selected
    Then the ports should be <ports>
    Examples:
      | host            | startPort | endPort | threads | timeout | state | ports         |
      | localhost       | 1         | 65535   | 100     | 500     | open  | 80,443        |
      | www.example.com | 1         | 6500    | 10      | 500     | open  | 15, 6500, 300 |
      | 192.168.0.1     | 1         | 3       | 1       | 50      | closed| 1, 2          |
      # teste com 0 threads
      | myserver        | 1         | 3       | 0       | 1       | open  |               |
      # teste de timeout padrão (uma thread, pouco tempo e muitas portas)
      | myserver        | 1         | 65535   | 1       | 1       | open  |               |
      # teste de timeout impossível (0 ms para realizar a tarefa)
      | myserver        | 1         | 65535   | 100     | 0       | open  |               |
      # teste de porta final menor que inicial
      | myserver        | 50        | 25      | 20      | 50      | open  |               |
      # testes de 0 portas totais
      | myserver        | 0         | 0       | 20      | 50      | open  |               |
      # testes host inválido
      |                 | 1         | 6500    | 10      | 500     | open  | 15, 6500, 300 |
      |  null           | 1         | 6500    | 10      | 500     | open  | 15, 6500, 300 |
      | .com            | 1         | 6500    | 10      | 500     | open  | 15, 6500, 300 |
      # teste de entradas negativas
      | www.example.com | -1        | 6500    | 10      | 500     | open  |               |
      | www.example.com |  1        | -5      | 10      | 500     | open  |               |
      | www.example.com |  1        | 6500    | -1      | 500     | open  |               |
      | www.example.com |  1        | 6500    | 10      | -1      | open  |               |
      # teste de entradas zero
      | www.example.com | 0         | 6500    | 10      | 500     | open  |               |
      | www.example.com | 1         | 0       | 10      | 500     | open  |               |
      | www.example.com | 1         | 6500    | 0       | 500     | open  |               |






