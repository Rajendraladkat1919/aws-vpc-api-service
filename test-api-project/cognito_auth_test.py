import boto3
import requests
import json
import sys

# --- CONFIG ---
COGNITO_REGION = 'xxx'  # Change if needed
USER_POOL_CLIENT_ID = 'xxx'  # Replace with your actual client ID
API_URL = 'xxx'  # Replace with your API Gateway URL
USERNAME = 'xxx'  # Replace with your test user
PASSWORD = 'xxx'  # Replace with your test user's password

# --- AUTHENTICATE USER ---
def get_jwt_token():
    client = boto3.client('cognito-idp', region_name=COGNITO_REGION)
    try:
        resp = client.initiate_auth(
            AuthFlow='USER_PASSWORD_AUTH',
            AuthParameters={'USERNAME': USERNAME, 'PASSWORD': PASSWORD},
            ClientId=USER_POOL_CLIENT_ID
        )
        if 'ChallengeName' in resp and resp['ChallengeName'] == 'NEW_PASSWORD_REQUIRED':
            print("Setting new permanent password for the user...")
            challenge_resp = client.respond_to_auth_challenge(
                ClientId=USER_POOL_CLIENT_ID,
                ChallengeName='NEW_PASSWORD_REQUIRED',
                Session=resp['Session'],
                ChallengeResponses={
                    'USERNAME': USERNAME,
                    'NEW_PASSWORD': PASSWORD
                }
            )
            # Use AccessToken for API Gateway
            return challenge_resp['AuthenticationResult']['AccessToken']
        # Use AccessToken for API Gateway
        return resp['AuthenticationResult']['AccessToken']
    except client.exceptions.NotAuthorizedException:
        print("Incorrect username or password.")
    except client.exceptions.UserNotConfirmedException:
        print("User is not confirmed.")
    except client.exceptions.PasswordResetRequiredException:
        print("Password reset required for this user.")
    except KeyError:
        print("AuthenticationResult not found in response. Full response:")
        print(resp)
    except Exception as e:
        print(f"Unexpected error: {e}")
    sys.exit(1)

# --- CALL API ---
def call_api(token, method='GET', data=None):
    headers = {
        'Authorization': token,
        'Content-Type': 'application/json'
    }
    if method == 'GET':
        r = requests.get(API_URL, headers=headers)
    elif method == 'PUT':
        r = requests.put(API_URL, headers=headers, data=json.dumps(data))
    else:
        print('Unsupported method')
        sys.exit(1)
    print(f'Status: {r.status_code}')
    print(f'Response: {r.text}')

if __name__ == '__main__':
    token = get_jwt_token()
    print('JWT Token:', token)
    # Test GET
    call_api(token, method='GET')
    # Test PUT (example data)
    put_data = {'vpc_id': 'vpc-123', 'subnet_id': 'subnet-456'}
    call_api(token, method='PUT', data=put_data)
