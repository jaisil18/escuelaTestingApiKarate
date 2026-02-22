    @regression
Feature: Automatizar el backend de pet Store

  Background:
    * url apiPetStore
    * def dataPath = 'classpath:examples/jsonData/'
    * def imgPath = 'classpath:examples/imagen/'

    @TEST-1 @crearMascota @happypath
  Scenario: Verificar la creacion de una nueva mascota en Pet Store
    Given path 'pet'
    And request read(dataPath + 'create-pet.json')
    When method post
    Then status 200
    And print response
    * def idPet = response.id
    
    @TEST-2
  Scenario Outline: GET /pet/findByStatus Finds Pets by status - <status>
    Given path 'pet', 'findByStatus'
    And param status = '<status>'
    When method get
    Then status 200
    And print response

    Examples:
      | status    |
      | available |
      | pending   |
      | sold      |

    @TEST-3 @happypath
  Scenario: Actualizar una mascota existente en Pet Store
    * def petUpdate = read(dataPath + 'update-pet.json')
    Given path 'pet'
    And request petUpdate
    When method put
    Then status 200
    And match response.name == 'Leon'
    And print response

    @TEST-4
  Scenario Outline: Buscar una mascota por ID en Pet Store - <petId>
    Given path 'pet', <petId>
    When method get
    Then status 200
    And match response.id == <petId>
    And print response

    Examples:
      | petId |
      | 1     |
      | 2     |
      | 3     |

    @TEST-5
  Scenario: Eliminar una mascota por ID en Pet Store
    * def petData = read(dataPath + 'pet-id.json')
    Given path 'pet', petData.id
    When method delete
    Then status 200
    And print response

    @TEST-6
  Scenario: Subir una imagen para una mascota en Pet Store
    * def petData = read(dataPath + 'pet-id.json')
    Given path 'pet', petData.id, 'uploadImage'
    And multipart field additionalMetadata = 'fido_image'
    And multipart file file = { read: '#(imgPath + "dog.jpg")', filename: 'dog.jpg', contentType: 'image/jpeg' }
    When method post
    Then status 200
    And match response.message contains 'dog.jpg'
    And print response
  
    @TEST-7 @happypath
  Scenario: verificar la busqueda de mascotas por id - Ok
    * def result = call read('users.feature@crearMascota')
    * def createdId = result.idPet
    Given path 'pet', createdId
    When method get
    Then status 200
    And match response.id == createdId
    And print response