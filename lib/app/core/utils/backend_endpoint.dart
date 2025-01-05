class BackendEndpoint 
{
 static const baseUrl ='http://192.168.7.105:8000';
 static const api ='/api';
 static const auth = '$api/auth';
 static const login = '$auth/login';
 static const logout = '$auth/logout';
 static const visits = '$api/visits';
 static const cancelled = '$visits/cancelled';
 static const archive = '$visits/archives';
}