package daos;

import Conexao.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import models.Usuario;

public class usuarioDAO {
    
    
    
    public void save(Usuario usuario){
        String sql = "INSERT INTO USUARIOS(username, nome, senha, funcao, status) VALUES (?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement pstm = null; 
        
        try{
            conn = Conexao.createConnectionToMySQL();
            
            pstm = (PreparedStatement) conn.prepareStatement(sql);
            pstm.setString(1,usuario.getUser_name());
            pstm.setString(2, usuario.getNome());
            pstm.setString(3,usuario.getSenha());
            pstm.setString(4, usuario.getCargo());
            pstm.setString(5,usuario.getStatus());
            
            pstm.execute();
        }
        catch (Exception e){
            e.printStackTrace();
        }finally{
            try{
                if(pstm!=null){
                    pstm.close();
                }
                if(conn!=null){
                    conn.close();
                }
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        
    }

    public void delete(Usuario usuario){
        String sql = "DELETE FROM USUARIOS "+"WHERE username=?";
        Connection conn = null;
        PreparedStatement pstm = null; 
        
        try{
            conn = Conexao.createConnectionToMySQL();
            
            pstm = (PreparedStatement) conn.prepareStatement(sql);
            pstm.setString(1,usuario.getUser_name());
            
            pstm.execute();
        }
        catch (Exception e){
            e.printStackTrace();
        }finally{
            try{
                if(pstm!=null){
                    pstm.close();
                }
                if(conn!=null){
                    conn.close();
                }
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        
    }
    public List<Usuario> getContatos(){
		
		String sql = "SELECT * FROM 2rp.usuarios";
		
		List<Usuario> usuarios = new ArrayList<Usuario>();
		
		Connection conn = null;
		PreparedStatement pstm = null;
		//Classe que vai recuperar os dados do banco. ***SELECT****
		ResultSet rset = null;
		
		try {
			conn = Conexao.createConnectionToMySQL();
			
			pstm = (PreparedStatement) conn.prepareStatement(sql);
			
			rset = pstm.executeQuery();
			
			while (rset.next()) {
				
				Usuario usuario = new Usuario();
				
				//Recuperar o id
				usuario.setUser_name(rset.getString("username"));
				//Recuperar o nome
				usuario.setNome(rset.getString("nome"));
				//Recuperar a idade
                                usuario.setSenha(rset.getString("senha"));
				usuario.setCargo(rset.getString("funcao"));
				//Recuperar a data de cadastrado
				usuario.setStatus(rset.getString("status"));
				
				usuarios.add(usuario);
				
			}
		}catch (Exception e) {
				e.printStackTrace();
			}finally {
				try {
					if(rset!=null) {
						rset.close();
					}
					
					if(pstm!=null) {
						pstm.close();
					}
					
					if(conn!=null) {
						conn.close();
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
                        System.out.println(usuarios);
			return usuarios;
	}
}