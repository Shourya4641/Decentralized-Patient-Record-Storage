### README

# MedicalRecord Smart Contract

## Overview
The `MedicalRecord` smart contract is designed to manage medical records on the Ethereum blockchain securely. It allows authorized users (doctors, patients, and an admin) to interact with the system, ensuring data privacy and integrity.

## Features
- **Admin Role**: An admin manages doctors, patients, and medicines.
- **Doctor Role**: Doctors can add diseases to patients and prescribe medicines.
- **Patient Role**: Patients can view their records and update their age.
- **Secure Access**: Only authorized users can access and modify specific data.

## Installation and Usage with Remix IDE

1. **Open Remix IDE**: Go to [Remix IDE](https://remix.ethereum.org/).

2. **Create a New File**: In the file explorer, create a new file and name it `MedicalRecord.sol`.

3. **Paste the Contract Code**: Copy the smart contract code into the `MedicalRecord.sol` file.

4. **Compile the Contract**:
   - Go to the "Solidity Compiler" tab on the left sidebar.
   - Select the appropriate compiler version (0.8.24).
   - Click "Compile MedicalRecord.sol".

5. **Deploy the Contract**:
   - Go to the "Deploy & Run Transactions" tab on the left sidebar.
   - Select "JavaScript VM" for the environment (or connect to your preferred network).
   - Click "Deploy".

6. **Interact with the Contract**:
   - After deployment, the contract will appear under "Deployed Contracts".
   - Expand the contract to see available functions.
   - You can now call functions and interact with the contract.

## Smart Contract Details

### Contract: `MedicalRecord`

#### Structures
- **Doctor**: Stores information about doctors.
  ```solidity
  struct Doctor {
      uint id;
      string name;
      string qualification;
      string clinicAddress;
  }
  ```
- **Patient**: Stores information about patients.
  ```solidity
  struct Patient {
      uint id;
      string name;
      uint age;
      string gender;
  }
  ```
- **Medicine**: Stores details about medicines.
  ```solidity
  struct Medicine {
      uint id;
      string name;
      string expiryDate;
      string dose;
      string price;
  }
  ```
- **Disease**: Represents a disease.
  ```solidity
  struct Disease {
      string name;
  }
  ```

#### Mappings
- `doctors`: Maps doctor ID to a `Doctor` struct.
- `patients`: Maps patient ID to a `Patient` struct.
- `medicines`: Maps medicine ID to a `Medicine` struct.
- `prescribedMedicines`: Maps patient address to an array of `Medicine` structs.
- `patientDisease`: Maps patient ID to an array of `Disease` structs.

#### Functions
- **Admin Functions**
  - `registerDoctor`: Registers a new doctor.
  - `registerPatient`: Registers a new patient.
  - `addMedicine`: Adds a new medicine.
- **Doctor Functions**
  - `addNewDisease`: Adds a disease to a patient's record.
  - `prescribeMedicine`: Prescribes medicine to a patient.
- **Patient Functions**
  - `updateAge`: Updates a patient's age.
  - `viewRecord`: Views a patient's medical record.
  - `viewPrescribedMedicine`: Views prescribed medicines for a patient.
- **Public Functions**
  - `viewMedicine`: Views details of a medicine.
  - `viewPatientByDoctor`: Views a patient's details by a doctor.
  - `viewDoctorById`: Views details of a doctor.

### Modifiers
- `onlyAdmin`: Ensures only the admin can execute the function.
- `onlyDoctor`: Ensures only a registered doctor can execute the function.
- `onlyPatient`: Ensures only a registered patient can execute the function.

### Helper Functions
- `isDoctor`: Checks if an address belongs to a registered doctor.
- `isPatient`: Checks if an address belongs to a registered patient.
- `checkMedicine`: Checks if a medicine ID already exists.

## Example Deployment with Remix IDE

1. **Start Remix IDE**: Open [Remix IDE](https://remix.ethereum.org/).

2. **Deploy the Contract**: Follow the steps under the "Installation and Usage with Remix IDE" section to deploy the contract.

3. **Interact with the Contract**: Use the deployed contract interface in Remix to call functions and interact with the contract.

## Security
- Ensure the admin address is securely managed.
- Use secure development practices when writing and deploying smart contracts.

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.

---

This `MedicalRecord` contract ensures a secure and efficient way to manage medical records, providing various functionalities for different roles while maintaining data privacy and integrity.
